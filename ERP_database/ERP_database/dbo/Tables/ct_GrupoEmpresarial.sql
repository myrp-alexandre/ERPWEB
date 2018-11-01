CREATE TABLE [dbo].[ct_GrupoEmpresarial] (
    [IdGrupoEmpresarial] VARCHAR (15)  NOT NULL,
    [GrupoEmpresarial]   VARCHAR (200) NOT NULL,
    [Estado]             CHAR (1)      NOT NULL,
    CONSTRAINT [PK_ct_GrupoEmpresarial] PRIMARY KEY CLUSTERED ([IdGrupoEmpresarial] ASC)
);

