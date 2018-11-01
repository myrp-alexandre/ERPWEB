CREATE TABLE [dbo].[ct_GrupoEmpresarial_plancta] (
    [IdCuenta_gr]      VARCHAR (20)  NOT NULL,
    [pc_Cuenta_gr]     VARCHAR (150) NOT NULL,
    [IdCuentaPadre_gr] VARCHAR (20)  NULL,
    [pc_Naturaleza]    CHAR (1)      NOT NULL,
    [IdNivelCta_gr]    INT           NOT NULL,
    [IdGrupoCble_gr]   VARCHAR (5)   NOT NULL,
    [pc_EsMovimiento]  CHAR (1)      NOT NULL,
    [pc_Estado]        CHAR (1)      NOT NULL,
    CONSTRAINT [PK_ct_GrupoEmpresarial_plancta] PRIMARY KEY CLUSTERED ([IdCuenta_gr] ASC),
    CONSTRAINT [FK_ct_GrupoEmpresarial_plancta_ct_GrupoEmpresarial_grupocble] FOREIGN KEY ([IdGrupoCble_gr]) REFERENCES [dbo].[ct_GrupoEmpresarial_grupocble] ([IdGrupoCble_gr]),
    CONSTRAINT [FK_ct_GrupoEmpresarial_plancta_ct_GrupoEmpresarial_plancta] FOREIGN KEY ([IdCuentaPadre_gr]) REFERENCES [dbo].[ct_GrupoEmpresarial_plancta] ([IdCuenta_gr]),
    CONSTRAINT [FK_ct_GrupoEmpresarial_plancta_ct_GrupoEmpresarial_plancta_nivel] FOREIGN KEY ([IdNivelCta_gr]) REFERENCES [dbo].[ct_GrupoEmpresarial_plancta_nivel] ([IdNivelCta_gr])
);

