<p align="center">
  <h1 align="center">sefaria.nvim</h2>
</p>

<p align="center">
    > An updated version of <a href="https://github.com/sammyshear/drash.nvim">drash.nvim</a> that works better, using better practices, and uses snacks.nvim in place of telescope.
</p>

## Features

The plugin provides a command `Parsha` which will open the Parsha for the week and create a buffer user command `Commentaries` that opens a snacks picker of the commentaries related to the Parsha. Some commentaries don't seem to have a usable version, so you might get an error that says "no version found" when selecting one, but most of them seem to work.

The plugin also provides the `SearchSefaria` command which allows you to make use of the Sefaria ElasticSearch API to search any texts on the website for arbitrary queries. The command takes an argument that is your search query and opens a snacks.nvim picker to allow you to select the text you want to see.

## Installation

[folke/lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
  {
    "sammyshear/sefaria.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
  },
```
