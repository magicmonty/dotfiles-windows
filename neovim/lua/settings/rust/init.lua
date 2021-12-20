local status,rust_tools = pcall(require, "rust-tools")
if not status then return end

rust_tools.setup {  }
