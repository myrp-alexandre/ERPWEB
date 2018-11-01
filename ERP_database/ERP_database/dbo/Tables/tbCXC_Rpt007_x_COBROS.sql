CREATE TABLE [dbo].[tbCXC_Rpt007_x_COBROS] (
    [IdEmpresa]        INT          NOT NULL,
    [IdSucursal]       INT          NOT NULL,
    [IdBodega]         INT          NULL,
    [IdCbteVta]        NUMERIC (18) NOT NULL,
    [vt_tipoDoc]       VARCHAR (20) NULL,
    [IdCobro]          NUMERIC (18) NULL,
    [IdCobro_tipo]     VARCHAR (20) NOT NULL,
    [dc_TipoDocumento] VARCHAR (20) NULL,
    [vt_total]         FLOAT (53)   NULL
);

