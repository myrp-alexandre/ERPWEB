CREATE TABLE [dbo].[tb_banco_estado_reg__resp_bancaria] (
    [IdBanco]               INT          NOT NULL,
    [IdEstado_Reg_cat]      VARCHAR (10) NOT NULL,
    [IdEstado_Reg_Bancario] VARCHAR (50) NOT NULL,
    [observacion]           VARCHAR (50) NOT NULL,
    [Genera_anulacion]      BIT          NULL,
    CONSTRAINT [PK_tb_banco_estado_reg__resp_bancaria] PRIMARY KEY CLUSTERED ([IdBanco] ASC, [IdEstado_Reg_cat] ASC, [IdEstado_Reg_Bancario] ASC),
    CONSTRAINT [FK_tb_banco_estado_reg__resp_bancaria_tb_banco] FOREIGN KEY ([IdBanco]) REFERENCES [dbo].[tb_banco] ([IdBanco])
);

