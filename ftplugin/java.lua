local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name
local java_dap_path = home .. "/java/java-debug-0.52.0/com.microsoft.java.debug.plugin/target/"
local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	settings = {
		java = {
			signatureHelp = { enabled = true },
			extendedClientCapabilities = extendedClientCapabilities,
			maven = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				enabled = true,
			},
		},
	},

	init_options = {
		bundles = {
			vim.fn.glob(java_dap_path .. "com.microsoft.java.debug.plugin-0.52.0.jar", 1),
		},
	},
}
config["on_attach"] = function(client, bufnr)
	require("jdtls").setup_dap({ hotcodereplace = "auto" })
end
require("jdtls").start_or_attach(config)

-- keymaps
vim.keymap.set("n", "<leader>co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "Organize Imports" })
vim.keymap.set("n", "<leader>crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "Extract Variable" })
vim.keymap.set(
	"v",
	"<leader>crv",
	"<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
	{ desc = "Extract Variable" }
)
vim.keymap.set("n", "<leader>crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "Extract Constant" })
vim.keymap.set(
	"v",
	"<leader>crc",
	"<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
	{ desc = "Extract Constant" }
)
vim.keymap.set(
	"v",
	"<leader>crm",
	"<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
	{ desc = "Extract Method" }
)

-- dap
local function get_spring_boot_runner(profile, debug)
	local debug_param = ""
	if debug then
		debug_param =
			' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
	end

	local profile_param = ""
	if profile then
		profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
	end

	return "mvn spring-boot:run " .. profile_param .. debug_param
end

local function run_spring_boot(debug)
	vim.cmd("term " .. get_spring_boot_runner("local", debug))
end

vim.api.nvim_create_user_command("SpringRun", function(opts)
	run_spring_boot()
end, {})
vim.api.nvim_create_user_command("SpringRunDev", function(opts)
	run_spring_boot(true)
end, {})

local function get_test_runner(test_name, debug)
	if debug then
		return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"'
	end
	return 'mvn test -Dtest="' .. test_name .. '"'
end

local function run_java_test_method(debug)
	local utils = require("mata649.utils")
	local method_name = utils.get_current_full_method_name("\\#")
	vim.cmd("term" .. get_test_runner(method_name, debug))
end

local function run_java_test_class(debug)
	local utils = require("mata649.utils")
	local class_name = utils.get_current_full_class_name()
	vim.cmd("term" .. get_test_runner(class_name, debug))
end

vim.keymap.set("n", "<leader>tm", function()
	run_java_test_method()
end)
vim.keymap.set("n", "<leader>TM", function()
	run_java_test_method(true)
end)
vim.keymap.set("n", "<leader>tc", function()
	run_java_test_class()
end)
vim.keymap.set("n", "<leader>TC", function()
	run_java_test_class(true)
end)
