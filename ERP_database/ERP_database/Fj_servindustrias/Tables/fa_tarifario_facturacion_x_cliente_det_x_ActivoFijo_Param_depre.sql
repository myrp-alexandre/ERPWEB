CREATE TABLE [Fj_servindustrias].[fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo_Param_depre] (
    [IdEmpresa]                  INT          NOT NULL,
    [IdTarifario]                NUMERIC (18) NOT NULL,
    [IdActivoFijo]               INT          NOT NULL,
    [Af_porcentaje_deprec]       FLOAT (53)   NULL,
    [Af_anios_vida_util]         INT          NULL,
    [Af_costo_historico]         FLOAT (53)   NULL,
    [Af_costo_compra]            FLOAT (53)   NULL,
    [Af_Meses_depreciar]         INT          NULL,
    [Af_fecha_ini_depre]         DATETIME     NULL,
    [Af_fecha_fin_depre]         DATETIME     NULL,
    [Af_ValorSalvamento]         FLOAT (53)   NULL,
    [Af_ValorResidual]           FLOAT (53)   NULL,
    [se_factura_valorSalvamento] BIT          NULL,
    [se_factura_Iva]             BIT          NULL,
    CONSTRAINT [PK_fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo_Param_depre] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTarifario] ASC, [IdActivoFijo] ASC),
    CONSTRAINT [FK_fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo_Param_depre_fa_tarifario_facturacion_x_cliente] FOREIGN KEY ([IdEmpresa], [IdTarifario]) REFERENCES [Fj_servindustrias].[fa_tarifario_facturacion_x_cliente] ([IdEmpresa], [IdTarifario])
);

