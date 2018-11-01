CREATE TABLE [dbo].[in_rptMovi_Inv_x_prod_resumido] (
    [IdEmpresa]     INT            NOT NULL,
    [IdSucursal]    INT            NOT NULL,
    [IdBodega]      INT            NOT NULL,
    [IdProducto]    NUMERIC (18)   NOT NULL,
    [CodProducto]   VARCHAR (50)   NULL,
    [IdCategoria]   VARCHAR (25)   NULL,
    [pr_peso]       FLOAT (53)     NULL,
    [stock]         FLOAT (53)     NULL,
    [Nom_Sucursal]  VARCHAR (50)   NULL,
    [Nom_Bodega]    VARCHAR (50)   NULL,
    [Nom_Producto]  NVARCHAR (500) NULL,
    [Nom_Categoria] VARCHAR (100)  NULL,
    [Nom_Empresa]   VARCHAR (50)   NULL,
    [IdUsuario]     VARCHAR (20)   NULL,
    CONSTRAINT [PK_in_rptMovi_Inv_x_prod_resumido] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdProducto] ASC)
);

