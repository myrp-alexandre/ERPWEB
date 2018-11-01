CREATE TABLE [dbo].[ba_Cbte_Ban_tipo_x_CodBancoExterno] (
    [CodTipoCbteBan] VARCHAR (20) NOT NULL,
    [CodBanco]       VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_ba_Cbte_Ban_tipo_x_CodBancoExterno_1] PRIMARY KEY CLUSTERED ([CodTipoCbteBan] ASC, [CodBanco] ASC),
    CONSTRAINT [FK_ba_Cbte_Ban_tipo_x_CodBancoExterno_ba_Cbte_Ban_tipo] FOREIGN KEY ([CodTipoCbteBan]) REFERENCES [dbo].[ba_Cbte_Ban_tipo] ([CodTipoCbteBan])
);

