return {
  settings = {
    pylsp = {
      plugins = {
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        mccabe = { enabled = true },
        -- linter options
        pylint = { enabled = false, executable = "pylint" },
        flake8 = { enabled = true, maxLineLength = 88 },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
      },
    },
  },
}
