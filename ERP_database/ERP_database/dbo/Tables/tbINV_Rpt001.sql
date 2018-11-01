CREATE TABLE [dbo].[tbINV_Rpt001] (
    [IdEmpresa_SP]        INT            NOT NULL,
    [IdUsuario_SP]        VARCHAR (20)   NOT NULL,
    [Fecha_Transac]       DATETIME       NULL,
    [nom_pc]              VARCHAR (20)   NULL,
    [Su_Descripcion]      NCHAR (60)     NOT NULL,
    [bo_Descripcion]      NCHAR (100)    NOT NULL,
    [IdCategoria]         VARCHAR (25)   NOT NULL,
    [ca_Categoria]        VARCHAR (100)  NOT NULL,
    [pr_codigo]           VARCHAR (50)   NULL,
    [pr_descripcion]      NVARCHAR (500) NULL,
    [pr_peso]             FLOAT (53)     NULL,
    [stock]               FLOAT (53)     NULL,
    [Tonelaje_x_Sucursal] FLOAT (53)     NULL,
    [pr_Pedidos]          FLOAT (53)     NOT NULL,
    [Toneladas_x_Pedido]  FLOAT (53)     NULL,
    [Disponible]          FLOAT (53)     NULL,
    [Tonelaje_Disponible] FLOAT (53)     NULL,
    CONSTRAINT [PK_tbINV_Rpt001] PRIMARY KEY CLUSTERED ([IdEmpresa_SP] ASC, [IdUsuario_SP] ASC)
);

