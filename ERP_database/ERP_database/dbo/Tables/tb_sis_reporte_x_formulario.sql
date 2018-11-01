CREATE TABLE [dbo].[tb_sis_reporte_x_formulario] (
    [IdFormulario] VARCHAR (250) NOT NULL,
    [CodReporte]   VARCHAR (50)  NOT NULL,
    [observacion]  VARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_tb_sis_reporte_x_formulario] PRIMARY KEY CLUSTERED ([IdFormulario] ASC, [CodReporte] ASC),
    CONSTRAINT [FK_tb_sis_reporte_x_formulario_tb_sis_formulario] FOREIGN KEY ([IdFormulario]) REFERENCES [dbo].[tb_sis_formulario] ([IdFormulario]),
    CONSTRAINT [FK_tb_sis_reporte_x_formulario_tb_sis_reporte] FOREIGN KEY ([CodReporte]) REFERENCES [dbo].[tb_sis_reporte] ([CodReporte])
);

