vim.g.Lf_WorkingDirectoryMode = "F"

vim.g.Lf_WindowPosition = "popup"
vim.g.Lf_PreviewInPopup = 1

vim.g.Lf_DefaultMode = "FullPath"
vim.g.Lf_DefaultExternalTool = "rg"
vim.g.Lf_UseVersionControlTool = 0
vim.g.Lf_ShowHidden = 1

vim.g.Lf_UseCache = 0
vim.g.Lf_UseMemoryCache = 0

-- Keymaps
vim.g.Lf_ShortcutF = ""
vim.g.Lf_ShortcutB = ""

vim.keymap.set("n", "<leader>ff", function()
	vim.cmd.Leaderf("file")
end)

vim.keymap.set("n", "<leader>fg", function()
	vim.cmd.Leaderf("rg")
end)

-- use ctrl-n and ctrl-p to navigate items.
-- vim.cmd([[let g:Lf_CommandMap = {'<C-N>': ['<a-J>'], '<C-P>': ['<C-K>']}]])

vim.g.Lf_WildIgnore = {
	dir = { ".git", "__pycache__", ".DS_Store" },
	file = {
		"*.exe",
		"*.dll",
		"*.so",
		"*.o",
		"*.pyc",
		"*.jpg",
		"*.png",
		"*.gif",
		"*.svg",
		"*.ico",
		"*.db",
		"*.tgz",
		"*.tar.gz",
		"*.gz",
		"*.zip",
		"*.bin",
		"*.pptx",
		"*.xlsx",
		"*.docx",
		"*.pdf",
		"*.tmp",
		"*.wmv",
		"*.mkv",
		"*.mp4",
		"*.rmvb",
		"*.ttf",
		"*.ttc",
		"*.otf",
		"*.mp3",
		"*.aac",
	},
}
