CREATE TABLE [Naturisa].[cp_CXP_NATU_Rpt004] (
    [IdEmpresa]              INT           NOT NULL,
    [IdProveedor]            NUMERIC (18)  NOT NULL,
    [IdUsuario]              VARCHAR (20)  NOT NULL,
    [nom_proveedor]          VARCHAR (200) NOT NULL,
    [Saldo_inicial]          FLOAT (53)    NOT NULL,
    [Debitos]                FLOAT (53)    NOT NULL,
    [Creditos]               FLOAT (53)    NOT NULL,
    [Saldo]                  FLOAT (53)    NOT NULL,
    [descripcion_clas_prove] VARCHAR (200) NOT NULL,
    [IdClaseProveedor]       INT           NOT NULL,
    CONSTRAINT [PK_cp_CXP_NATU_Rpt004] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdProveedor] ASC, [IdUsuario] ASC)
);

