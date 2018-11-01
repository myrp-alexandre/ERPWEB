CREATE TABLE [dbo].[ct_GrupoEmpresarial_grupocble] (
    [IdGrupoCble_gr]       VARCHAR (5)  NOT NULL,
    [gc_GrupoCble_gr]      VARCHAR (50) NOT NULL,
    [gc_Orden]             INT          NOT NULL,
    [gc_estado_financiero] VARCHAR (50) NOT NULL,
    [gc_signo_operacion]   INT          NOT NULL,
    CONSTRAINT [PK_ct_GrupoEmpresarial_grupocble] PRIMARY KEY CLUSTERED ([IdGrupoCble_gr] ASC)
);

