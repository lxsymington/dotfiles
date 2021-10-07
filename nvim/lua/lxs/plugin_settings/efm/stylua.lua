return {
	formatCommand = ([[
        stylua
        ${--column-width:column_width}
        ${--indent-type:indent_type}
        ${--indent-width:indent_width}
        ${--line-endings:line_endings}
        ${--quote-style:quote_style}
        --stdin-filepath ${INPUT} -
    ]]):gsub("\n", ""),
	formatStdin = true,
}
