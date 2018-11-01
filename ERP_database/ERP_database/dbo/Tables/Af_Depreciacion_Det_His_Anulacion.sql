CREATE TABLE [dbo].[Af_Depreciacion_Det_His_Anulacion] (
    [IdEmpresa]          INT           NOT NULL,
    [IdHisDepreciacion]  INT           NOT NULL,
    [Secuencia]          INT           NOT NULL,
    [IdDepreciacion]     DECIMAL (18)  NOT NULL,
    [IdTipoDepreciacion] INT           NOT NULL,
    [IdActivoFijo]       INT           NOT NULL,
    [Ciclo]              INT           NOT NULL,
    [Concepto]           VARCHAR (100) NULL,
    [Valor_Compra]       FLOAT (53)    NOT NULL,
    [Valor_Salvamento]   FLOAT (53)    NOT NULL,
    [Vida_Util]          INT           NOT NULL,
    [Porc_Depreciacion]  FLOAT (53)    NOT NULL,
    [Valor_Depreciacion] FLOAT (53)    NOT NULL,
    [Valor_Depre_Acum]   FLOAT (53)    NOT NULL,
    [Valor_Importe]      FLOAT (53)    NOT NULL,
    [Es_Activo_x_Mejora] BIT           NOT NULL,
    CONSTRAINT [PK_Af_His_Depre_Det_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdHisDepreciacion] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_Af_Depreciacion_Det_His_Anulacion_Af_Activo_fijo] FOREIGN KEY ([IdEmpresa], [IdActivoFijo]) REFERENCES [dbo].[Af_Activo_fijo] ([IdEmpresa], [IdActivoFijo]),
    CONSTRAINT [FK_Af_His_Depre_Det_Af_His_Depre] FOREIGN KEY ([IdEmpresa], [IdHisDepreciacion]) REFERENCES [dbo].[Af_Depreciacion_His_Anulacion] ([IdEmpresa], [IdHisDepreciacion])
);

