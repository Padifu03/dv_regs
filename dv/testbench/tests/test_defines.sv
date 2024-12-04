// Definición de macros para los valores por defecto
// Direcciones de los registros
`define FIR_COEF_0_ADDR   8'h00   // Dirección del registro FIR_COEF_0
`define FIR_COEF_1_ADDR   8'h01   // Dirección del registro FIR_COEF_1
`define FIR_COEF_2_ADDR   8'h02   // Dirección del registro FIR_COEF_2
`define FIR_DIV_ADDR      8'h03   // Dirección del registro FIR_DIV
`define CIC_COEF_ADDR     8'h04   // Dirección del registro CIC_COEF
`define CHIP_ID_ADDR      8'h05   // Dirección del registro CHIP_ID
`define CONTROL_ADDR      8'h06   // Dirección del registro CONTROL
`define OUTPUT_ADDR       8'h07   // Dirección del registro OUTPUT

// Valores por defecto de los registros
`define FIR_COEF_0_DEF    8'h01   // Valor por defecto del registro FIR_COEF_0 (coef0)
`define FIR_COEF_1_DEF    8'h00   // Valor por defecto del registro FIR_COEF_1 (coef1)
`define FIR_COEF_2_DEF    8'h00   // Valor por defecto del registro FIR_COEF_2 (coef2)
`define FIR_DIV_DEF       8'h00   // Valor por defecto del registro FIR_DIV (div)
`define CIC_COEF_DEF      8'h01   // Valor por defecto del registro CIC_COEF (dr)
`define CHIP_ID_DEF       8'hA5   // Valor por defecto del registro CHIP_ID (ID)
`define OUTPUT_DEF        8'h00   // Valor por defecto del registro OUTPUT (output)
`define ERROR_DEF         8'h02   // Valor por defecto erróneo

