CREATE TABLE [Fj_servindustrias].[fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det] (
    [IdEmpresa]          INT           NOT NULL,
    [IdDepreciacion]     DECIMAL (18)  NOT NULL,
    [IdTarifario]        NUMERIC (18)  NOT NULL,
    [Secuencia]          INT           NOT NULL,
    [IdTipoDepreciacion] INT           NOT NULL,
    [IdActivoFijo]       INT           NOT NULL,
    [Concepto]           VARCHAR (500) NULL,
    [Valor_Compra]       FLOAT (53)    NOT NULL,
    [Valor_Salvamento]   FLOAT (53)    NOT NULL,
    [Vida_Util]          INT           NOT NULL,
    [Porc_Depreciacion]  FLOAT (53)    NOT NULL,
    [Valor_Depreciacion] FLOAT (53)    NOT NULL,
    [Valor_Depre_Acum]   FLOAT (53)    NOT NULL,
    [Valor_Importe]      FLOAT (53)    NOT NULL,
    [IdPeriodo]          INT           NOT NULL,
    CONSTRAINT [PK_Af_Depreciacion_Det_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdDepreciacion] ASC, [IdTarifario] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det_fa_tarifario_facturacion_x_cliente_Af_Depreciacion] FOREIGN KEY ([IdEmpresa], [IdDepreciacion], [IdTarifario]) REFERENCES [Fj_servindustrias].[fa_tarifario_facturacion_x_cliente_Af_Depreciacion] ([IdEmpresa], [IdDepreciacion], [IdTarifario])
);

