CREATE TABLE [dbo].[in_rptDispInve] (
    [EmpresaSi]      INT            NOT NULL,
    [IdSucursalSi]   INT            NOT NULL,
    [IdBodegaSi]     INT            NOT NULL,
    [IdProductoSi]   NUMERIC (18)   NOT NULL,
    [Su_Descripcion] NCHAR (60)     NOT NULL,
    [bo_Descripcion] NCHAR (100)    NOT NULL,
    [pr_codigo]      VARCHAR (50)   NULL,
    [pr_descripcion] NVARCHAR (500) NULL,
    [IdCategoria]    VARCHAR (25)   NOT NULL,
    [pr_peso]        FLOAT (53)     NULL,
    [ca_Categoria]   VARCHAR (100)  NOT NULL,
    [IdEmpresa]      INT            NULL,
    [IdSucursal]     INT            NULL,
    [IdBodega]       INT            NULL,
    [IdProducto]     NUMERIC (18)   NULL,
    [stock]          FLOAT (53)     NULL,
    [pr_Pedidos]     FLOAT (53)     NOT NULL,
    [IdUsuario]      VARCHAR (20)   NOT NULL,
    CONSTRAINT [PK_in_rptDispInve] PRIMARY KEY CLUSTERED ([EmpresaSi] ASC, [IdSucursalSi] ASC, [IdBodegaSi] ASC, [IdProductoSi] ASC, [IdCategoria] ASC, [IdUsuario] ASC)
);

