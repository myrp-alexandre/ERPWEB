CREATE TABLE [dbo].[cxc_cancelacion_Intercompany_det] (
    [IdEmpresa]          INT          NOT NULL,
    [IdCancelacion]      NUMERIC (18) NOT NULL,
    [Secuencia]          INT          NOT NULL,
    [cbteVta_IdEmpresa]  INT          NOT NULL,
    [cbteVta_IdSucursal] INT          NOT NULL,
    [cbteVta_IdBodega]   INT          NOT NULL,
    [cbteVta_TipoDoc]    VARCHAR (20) NOT NULL,
    [cbteVta_IdCbteVta]  NUMERIC (18) NOT NULL,
    [cbr_IdEmpresa]      INT          NULL,
    [cbr_IdSucursal]     INT          NULL,
    [cbr_IdCobro]        NUMERIC (18) NULL,
    [Valor_Aplicado]     FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_cxc_cancelacion_Intercompany_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCancelacion] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_cxc_cancelacion_Intercompany_det_cxc_cancelacion_Intercompany] FOREIGN KEY ([IdEmpresa], [IdCancelacion]) REFERENCES [dbo].[cxc_cancelacion_Intercompany] ([IdEmpresa], [IdCancelacion])
);

