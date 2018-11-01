CREATE TABLE [dbo].[cxc_rpt_tmp_Cobros_fecha_corte_SP012] (
    [IdEmpresa]        INT           NOT NULL,
    [IdSucursal]       INT           NOT NULL,
    [IdBodega]         INT           NULL,
    [IdCbteVta]        NUMERIC (18)  NOT NULL,
    [vt_tipoDoc]       VARCHAR (20)  NULL,
    [IdCobro]          NUMERIC (18)  NULL,
    [IdCobro_tipo]     VARCHAR (20)  NOT NULL,
    [dc_TipoDocumento] VARCHAR (20)  NULL,
    [vt_total]         FLOAT (53)    NULL,
    [vt_Observacion]   VARCHAR (500) NULL
);

