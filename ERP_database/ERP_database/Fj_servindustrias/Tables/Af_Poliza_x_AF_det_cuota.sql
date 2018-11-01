CREATE TABLE [Fj_servindustrias].[Af_Poliza_x_AF_det_cuota] (
    [IdEmpresa]               INT           NOT NULL,
    [IdPoliza]                NUMERIC (18)  NOT NULL,
    [cod_couta]               VARCHAR (50)  NOT NULL,
    [Fecha_Pago]              DATE          NOT NULL,
    [valor_prima]             FLOAT (53)    NOT NULL,
    [IdEstadoCancelacion_cat] VARCHAR (50)  NOT NULL,
    [IdEstadoFacturacion_cat] VARCHAR (50)  NOT NULL,
    [Sub_total_12]            FLOAT (53)    NOT NULL,
    [Iva]                     FLOAT (53)    NOT NULL,
    [Observacion_detalle]     VARCHAR (200) NULL,
    [Sub_total_0]             FLOAT (53)    NULL,
    CONSTRAINT [PK_Af_Poliza_x_AF_det_cuota] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPoliza] ASC, [cod_couta] ASC)
);

