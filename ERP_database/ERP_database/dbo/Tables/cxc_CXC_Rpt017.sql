CREATE TABLE [dbo].[cxc_CXC_Rpt017] (
    [IdEmpresa]        INT           NOT NULL,
    [IdSucursal]       INT           NOT NULL,
    [IdBodega]         INT           NOT NULL,
    [IdCbte_vta_nota]  NUMERIC (18)  NOT NULL,
    [dc_TipoDocumento] VARCHAR (20)  NOT NULL,
    [vt_total]         FLOAT (53)    NOT NULL,
    [dc_ValorPago]     FLOAT (53)    NOT NULL,
    [Saldo]            FLOAT (53)    NOT NULL,
    [IdCliente]        NUMERIC (18)  NOT NULL,
    [IdPersona]        NUMERIC (18)  NOT NULL,
    [nom_Cliente]      VARCHAR (200) NOT NULL,
    [pe_cedulaRuc]     VARCHAR (13)  NOT NULL,
    [IdProvincia]      VARCHAR (4)   NULL,
    [IdCiudad]         VARCHAR (4)   NULL,
    [IdParroquia]      VARCHAR (4)   NULL,
    [pe_Naturaleza]    VARCHAR (2)   NOT NULL,
    [vt_NumFactura]    VARCHAR (50)  NOT NULL,
    [vt_fecha]         DATETIME      NOT NULL,
    [vt_fech_venc]     DATETIME      NOT NULL,
    [ValorPago_mes]    FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_cxc_CXC_Rpt017] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdCbte_vta_nota] ASC, [dc_TipoDocumento] ASC)
);

