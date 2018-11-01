CREATE TABLE [dbo].[cxc_cobro_x_EstadoCobro] (
    [IdEmpresa]       INT           NOT NULL,
    [IdSucursal]      INT           NOT NULL,
    [IdCobro]         NUMERIC (18)  NOT NULL,
    [IdEstadoCobro]   VARCHAR (5)   NOT NULL,
    [Secuencia]       INT           NOT NULL,
    [IdCobro_tipo]    VARCHAR (20)  NULL,
    [observacion]     VARCHAR (200) NULL,
    [Fecha]           DATETIME      NOT NULL,
    [nt_IdSucursal]   INT           NULL,
    [nt_IdBodega]     INT           NULL,
    [nt_IdNota]       NUMERIC (18)  NULL,
    [IdBanco]         INT           NULL,
    [IdCbte_vta_nota] NUMERIC (18)  NULL,
    [IdUsuario]       VARCHAR (20)  NULL,
    [nom_pc]          VARCHAR (50)  NULL,
    [ip]              VARCHAR (50)  NULL,
    CONSTRAINT [PK_cxc_cobro_x_EstadoCobro] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdCobro] ASC, [IdEstadoCobro] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_cxc_cobro_x_EstadoCobro_cxc_cobro] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdCobro]) REFERENCES [dbo].[cxc_cobro] ([IdEmpresa], [IdSucursal], [IdCobro]),
    CONSTRAINT [FK_cxc_cobro_x_EstadoCobro_cxc_EstadoCobro] FOREIGN KEY ([IdEstadoCobro]) REFERENCES [dbo].[cxc_EstadoCobro] ([IdEstadoCobro])
);

