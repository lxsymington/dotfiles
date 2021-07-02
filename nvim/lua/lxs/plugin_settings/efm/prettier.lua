return {
	formatCommand = ([[
        prettierd
        ${--config-precedence:configPrecedence}
        ${--tab-width:tabWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
        --stdin
        --stdin-filepath ${INPUT}
    ]]):gsub("\n", ""),
	formatStdin = true,
}
