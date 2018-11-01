CREATE TABLE [dbo].[tb_banco_procesos_bancarios_x_empresa] (
    [IdEmpresa]                  INT          NOT NULL,
    [IdProceso_bancario_tipo]    VARCHAR (25) NOT NULL,
    [IdBanco]                    INT          NOT NULL,
    [cod_banco]                  VARCHAR (50) NOT NULL,
    [Codigo_Empresa]             VARCHAR (50) NULL,
    [Secuencial_detalle_inicial] NUMERIC (18) NULL,
    [IdTipoNota]                 INT          NULL,
    [Se_contabiliza]             BIT          NULL,
    CONSTRAINT [PK_tb_banco_procesos_bancarios_x_empresa_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdProceso_bancario_tipo] ASC),
    CONSTRAINT [FK_tb_banco_procesos_bancarios_x_empresa_ba_tipo_nota] FOREIGN KEY ([IdEmpresa], [IdTipoNota]) REFERENCES [dbo].[ba_tipo_nota] ([IdEmpresa], [IdTipoNota])
);

