CREATE TABLE [dbo].[cp_proveedor_Autorizacion] (
    [IdEmpresa]               INT          NOT NULL,
    [IdProveedor]             NUMERIC (18) NOT NULL,
    [IdAutorizacion]          NUMERIC (18) NOT NULL,
    [Serie1]                  VARCHAR (5)  NOT NULL,
    [Serie2]                  VARCHAR (5)  NOT NULL,
    [nAutorizacion]           VARCHAR (50) NOT NULL,
    [Valido_Hasta]            DATE         NOT NULL,
    [factura_inicial]         VARCHAR (50) NOT NULL,
    [factura_final]           VARCHAR (50) NOT NULL,
    [NumAutorizacionImprenta] VARCHAR (50) NULL,
    [Estado]                  BIT          NULL,
    CONSTRAINT [PK_cp_proveedor_Autorizacion] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdProveedor] ASC, [IdAutorizacion] ASC),
    CONSTRAINT [FK_cp_proveedor_Autorizacion_cp_proveedor] FOREIGN KEY ([IdEmpresa], [IdProveedor]) REFERENCES [dbo].[cp_proveedor] ([IdEmpresa], [IdProveedor])
);

