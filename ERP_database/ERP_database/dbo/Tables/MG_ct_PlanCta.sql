CREATE TABLE [dbo].[MG_ct_PlanCta] (
    [IdCtaCble]       NVARCHAR (255) NOT NULL,
    [pc_Cuenta]       NVARCHAR (255) NULL,
    [IdCtaCblePadre]  NVARCHAR (255) NULL,
    [IdNivelCta]      FLOAT (53)     NULL,
    [pc_EsMovimiento] NVARCHAR (255) NULL,
    [IdGrupoCble]     NVARCHAR (255) NULL,
    [pc_Naturaleza]   NVARCHAR (255) NULL,
    [pc_Estado]       NVARCHAR (255) NULL,
    CONSTRAINT [PK_Hoja1$] PRIMARY KEY CLUSTERED ([IdCtaCble] ASC)
);

