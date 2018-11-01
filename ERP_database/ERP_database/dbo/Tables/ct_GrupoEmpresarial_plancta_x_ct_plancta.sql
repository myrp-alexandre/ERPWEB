CREATE TABLE [dbo].[ct_GrupoEmpresarial_plancta_x_ct_plancta] (
    [IdGrupoEmpresarial] VARCHAR (15) NOT NULL,
    [IdCuenta_gr]        VARCHAR (20) NOT NULL,
    [IdEmpresa]          INT          NOT NULL,
    [IdCtaCble]          VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_ct_GrupoEmpresarial_plancta_x_ct_plancta] PRIMARY KEY CLUSTERED ([IdCuenta_gr] ASC, [IdEmpresa] ASC, [IdCtaCble] ASC, [IdGrupoEmpresarial] ASC),
    CONSTRAINT [FK_ct_GrupoEmpresarial_plancta_x_ct_plancta_ct_GrupoEmpresarial] FOREIGN KEY ([IdGrupoEmpresarial]) REFERENCES [dbo].[ct_GrupoEmpresarial] ([IdGrupoEmpresarial]),
    CONSTRAINT [FK_ct_GrupoEmpresarial_plancta_x_ct_plancta_ct_GrupoEmpresarial_plancta] FOREIGN KEY ([IdCuenta_gr]) REFERENCES [dbo].[ct_GrupoEmpresarial_plancta] ([IdCuenta_gr]),
    CONSTRAINT [FK_ct_GrupoEmpresarial_plancta_x_ct_plancta_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCtaCble]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble])
);

