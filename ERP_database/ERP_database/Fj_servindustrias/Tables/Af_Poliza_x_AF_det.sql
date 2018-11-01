CREATE TABLE [Fj_servindustrias].[Af_Poliza_x_AF_det] (
    [IdEmpresa]               INT           NOT NULL,
    [IdPoliza]                NUMERIC (18)  NOT NULL,
    [IdActivoFijo]            INT           NOT NULL,
    [secuencia]               INT           NOT NULL,
    [Subtotal_0]              FLOAT (53)    NULL,
    [Subtotal_12]             FLOAT (53)    NULL,
    [Iva]                     FLOAT (53)    NULL,
    [Prima]                   FLOAT (53)    NULL,
    [observacion_det]         VARCHAR (150) NULL,
    [IdEstadoFacturacion_cat] VARCHAR (20)  NOT NULL,
    CONSTRAINT [PK_Af_Poliza_x_AF_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPoliza] ASC, [secuencia] ASC, [IdActivoFijo] ASC),
    CONSTRAINT [FK_Af_Poliza_x_AF_det_Af_Activo_fijo] FOREIGN KEY ([IdEmpresa], [IdActivoFijo]) REFERENCES [dbo].[Af_Activo_fijo] ([IdEmpresa], [IdActivoFijo])
);

