CREATE TABLE [dbo].[in_Ing_Egr_Inven_estado_apro] (
    [IdEstadoAproba] VARCHAR (15) NOT NULL,
    [Descripcion]    VARCHAR (25) NOT NULL,
    [estado]         CHAR (1)     NOT NULL,
    CONSTRAINT [PK_in_Ing_Egr_Inven_estado_apro] PRIMARY KEY CLUSTERED ([IdEstadoAproba] ASC)
);

