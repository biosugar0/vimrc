local augend = require("dial.augend")
require("dial.config").augends:register_group({
	-- default augends used when no group name is specified
	default = {
		augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
		augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
		augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
		augend.date.alias["%Y-%m-%d"], -- date (2022-02-19, etc.)
		augend.date.alias["%m/%d"], -- date (02/19, etc.)
		augend.date.alias["%H:%M"], -- hour (01:30, etc.)
		augend.constant.alias.bool, -- boolean value (true <-> false)
		augend.semver.alias.semver,
		augend.constant.alias.ja_weekday_full,
		augend.case.new({
			types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
			cyclic = true,
		}),
	},
	case = {
		augend.case.new({
			types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
			cyclic = true,
		}),
	},
})
