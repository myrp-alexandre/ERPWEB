CREATE TABLE [dbo].[tb_sis_iconos] (
    [IdIcono]       VARCHAR (150) NOT NULL,
    [Icono]         IMAGE         NOT NULL,
    [descripcion]   VARCHAR (250) NOT NULL,
    [Extencion]     VARCHAR (250) NOT NULL,
    [FullName]      VARCHAR (250) NOT NULL,
    [Length]        NUMERIC (18)  NOT NULL,
    [DirectoryName] VARCHAR (250) NOT NULL,
    CONSTRAINT [PK_tb_sis_iconos] PRIMARY KEY CLUSTERED ([IdIcono] ASC)
);

