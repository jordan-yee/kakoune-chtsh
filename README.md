# kakoune-chtsh
A [Kakoune](https://kakoune.org/) plugin for the
[cht.sh](https://github.com/chubin/cheat.sh) documentation service.

- Quickly query cht.sh for reference docs on a language or unix utility.
- By default, results are opened in a kak instance in a new tmux window.
  - (Source code includes comments for using different strategies.)
- Close the kak instance to snap yourself right back to the orginal context.

Inspired by this [video](https://www.youtube.com/watch?v=hJzqEAf2U4I) about
implementing something similar in Neovim.

> Requires TMUX and [this plugin](https://github.com/eraserhd/kak-ansi) to work
> out-of-the box, but should be easy to modify for other setups if needed. Feel
> free to submit a PR or fork and run with it.

## Commands / Usage

`chtsh-lang`, alias: `chl`: query cheatsheets for a language
- auto-complete candidates for all supported languages
  - also includes a few special topics: cmake, django, flask, & git.
    - NOTE: this `git` cheatsheet seems to only cover the basics
    - more info about `git` can be discovered via `chtsh-util`
- after selecting a language you are prompted for a query (optional)
  - auto-complete candidates provided for special queries

Example:
1. command: `:chl rust`
2. prompt: `query: hello`
3. Example of hello world program in Rust is shown.

`chtsh-util`, alias: `chu`: query cheatsheets for a unix utility
- auto-complete uses shell commands available on your system
  - these are not guaranteed to be supported, but most probably are

Example:
1. command: `:chu grep`
2. prompt: `query: case insensitive`
3. Example commands for performing a case-insensitive grep search are shown.

> Tip: use `repl-new` & `repl-send-text` after selecting long commands to
> instantly send them to a REPL terminal.
> [This plugin](https://github.com/jordan-yee/kakoune-repl-mode) provides
> commands & mappings to streamline that a bit (`<space>re` sends selected text
> to the REPL window and evaluates it).

## Installation

Manual installation: copy the `.kak` files into your autoload, or `source` them
in your `kakrc`.

With `plug.kak`:
```
plug "jordan-yee/kakoune-chtsh"
```

## Misc. Notes

- Currently requires Kakoune to be launched with TMUX as the window manager.
  - It may be easy to modify it to use the provided `terminal` command as a
    fall-back to support other window managers.
- There's a `cht.sh` client that may provide better, more comprehensive
  experience if you don't mind simply jumping over to a new terminal to use it.

## Development

The kakscript in this plugin is written to be reloadable so that you can source
it after making a change to test things without restarting Kakoune.

I use this [quick-dev plugin](https://github.com/jordan-yee/kakoune-plugin-quick-dev)
to do that:
1. Open kakoune, then open the quick-dev file with `<space>qe`.
2. Add `source "<path-to>/chtsh.kak"`.
3. Edit `"<path-to>/chtsh.kak"`, probably by selecting that path and pressing `gf`.
4. After making changes press `<space>qr` to reload them.
5. Test your changes and repeat.
