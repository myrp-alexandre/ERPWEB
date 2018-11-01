CREATE TABLE [dbo].[cxc_spCXC_Rpt018] (
    [IdEmpresa]         INT            NOT NULL,
    [IdSucursal]        INT            NOT NULL,
    [IdBodega]          INT            NOT NULL,
    [IdCbteVta]         INT            NOT NULL,
    [dc_tipo_documento] VARCHAR (20)   NOT NULL,
    [observacion]       VARCHAR (1000) NULL,
    [num_documento]     VARCHAR (20)   NOT NULL,
    [fecha]             DATETIME       NOT NULL,
    [fecha_vcto]        DATETIME       NOT NULL,
    [IdCliente]         NUMERIC (18)   NOT NULL,
    [nom_cliente]       VARCHAR (500)  NOT NULL,
    [subtotal]          FLOAT (53)     NOT NULL,
    [valor_iva]         FLOAT (53)     NOT NULL,
    [valor_total]       FLOAT (53)     NOT NULL,
    [valor_retencion]   FLOAT (53)     NOT NULL,
    [valor_pagos]       FLOAT (53)     NOT NULL,
    [valor_nc]          FLOAT (53)     NOT NULL,
    [saldo]             FLOAT (53)     NOT NULL,
    CONSTRAINT [PK_cxc_spCXC_Rpt018] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdCbteVta] ASC, [dc_tipo_documento] ASC)
);

