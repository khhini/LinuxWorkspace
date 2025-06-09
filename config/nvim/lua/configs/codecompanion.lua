local spinner = require('customs.spinner')
spinner:init()

require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "gemma3",
    },
    inline = {
      adapter = "gemma3",
    },
  },

  adapters = {
    gemini = function()
      return require("codecompanion.adapters").extend("gemini", {
        env = {
          api_key = os.getenv("GEMINI_API_KEY")
        },
      })
    end,
    gemma3 = function ()
      return require("codecompanion.adapters").extend("ollama", {
        name = "gemma3",
        schema ={
          model = {
            default = "gemma3:latest",
          }
        }
      })
    end
  },

  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        show_result_in_chat = true,  -- Show mcp tool results in chat
        make_vars = true,            -- Convert resources to #variables
        make_slash_commands = true,  -- Add prompts as /slash commands
      }
    }
  }
})

