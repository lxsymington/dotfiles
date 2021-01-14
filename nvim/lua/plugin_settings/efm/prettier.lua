return {
    formatCommand = ([[
        ./node_modules/.bin/prettier
        ${--config-precedence:configPrecedence}
        ${--tab-width:tabWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
        --stdin-filepath ${INPUT}
    ]]):gsub("\n", ""),
    formatStdin = true
}
