CREATE TABLE [dbo].[ct_GrupoEmpresarial_plancta_nivel] (
    [IdNivelCta_gr]     INT          NOT NULL,
    [nv_NumDigitos_gr]  INT          NOT NULL,
    [nv_Descripcion_gr] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_ct_GrupoEmpresarial_plancta_nivel] PRIMARY KEY CLUSTERED ([IdNivelCta_gr] ASC)
);

