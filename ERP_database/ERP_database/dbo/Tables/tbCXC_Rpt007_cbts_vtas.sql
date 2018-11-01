CREATE TABLE [dbo].[tbCXC_Rpt007_cbts_vtas] (
    [IdEmpresa]    INT          NOT NULL,
    [IdSucursal]   INT          NOT NULL,
    [IdBodega]     INT          NULL,
    [IdCbteVta]    NUMERIC (18) NOT NULL,
    [vt_tipoDoc]   VARCHAR (20) NULL,
    [Monto]        FLOAT (53)   NULL,
    [TotalCobrado] FLOAT (53)   NULL
);

