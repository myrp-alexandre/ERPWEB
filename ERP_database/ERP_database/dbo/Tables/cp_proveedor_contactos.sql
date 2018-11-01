CREATE TABLE [dbo].[cp_proveedor_contactos] (
    [IdEmpresa_prov] INT          NOT NULL,
    [IdProveedor]    NUMERIC (18) NOT NULL,
    [IdEmpresa_cont] INT          NOT NULL,
    [IdContacto]     NUMERIC (18) NOT NULL,
    [observacion]    VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_cp_proveedor_contactos] PRIMARY KEY CLUSTERED ([IdEmpresa_prov] ASC, [IdProveedor] ASC, [IdEmpresa_cont] ASC, [IdContacto] ASC),
    CONSTRAINT [FK_cp_proveedor_contactos_cp_proveedor] FOREIGN KEY ([IdEmpresa_prov], [IdProveedor]) REFERENCES [dbo].[cp_proveedor] ([IdEmpresa], [IdProveedor]),
    CONSTRAINT [FK_cp_proveedor_contactos_tb_contacto] FOREIGN KEY ([IdEmpresa_cont], [IdContacto]) REFERENCES [dbo].[tb_contacto] ([IdEmpresa], [IdContacto])
);

