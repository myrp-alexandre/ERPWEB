namespace Core.Erp.Web.Reportes.Facturacion
{
    partial class FAC_010_Rpt
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.objectDataSource1 = new DevExpress.DataAccess.ObjectBinding.ObjectDataSource(this.components);
            this.p_IdEmpresa = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdProducto = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdCategoria = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdLinea = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdGrupo = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdSubGrupo = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdMarca = new DevExpress.XtraReports.Parameters.Parameter();
            ((System.ComponentModel.ISupportInitialize)(this.objectDataSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // Detail
            // 
            this.Detail.HeightF = 100F;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // TopMargin
            // 
            this.TopMargin.HeightF = 100F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // BottomMargin
            // 
            this.BottomMargin.HeightF = 100F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // objectDataSource1
            // 
            this.objectDataSource1.DataSource = typeof(Core.Erp.Info.Reportes.Facturacion.FAC_010_Info);
            this.objectDataSource1.Name = "objectDataSource1";
            // 
            // p_IdEmpresa
            // 
            this.p_IdEmpresa.Name = "p_IdEmpresa";
            this.p_IdEmpresa.Visible = false;
            // 
            // p_IdProducto
            // 
            this.p_IdProducto.Name = "p_IdProducto";
            this.p_IdProducto.Visible = false;
            // 
            // p_IdCategoria
            // 
            this.p_IdCategoria.Name = "p_IdCategoria";
            this.p_IdCategoria.Visible = false;
            // 
            // p_IdLinea
            // 
            this.p_IdLinea.Name = "p_IdLinea";
            this.p_IdLinea.Visible = false;
            // 
            // p_IdGrupo
            // 
            this.p_IdGrupo.Name = "p_IdGrupo";
            this.p_IdGrupo.Visible = false;
            // 
            // p_IdSubGrupo
            // 
            this.p_IdSubGrupo.Name = "p_IdSubGrupo";
            this.p_IdSubGrupo.Visible = false;
            // 
            // p_IdMarca
            // 
            this.p_IdMarca.Name = "p_IdMarca";
            this.p_IdMarca.Visible = false;
            // 
            // FAC_010_Rpt
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin});
            this.ComponentStorage.AddRange(new System.ComponentModel.IComponent[] {
            this.objectDataSource1});
            this.DataSource = this.objectDataSource1;
            this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.p_IdEmpresa,
            this.p_IdProducto,
            this.p_IdCategoria,
            this.p_IdLinea,
            this.p_IdGrupo,
            this.p_IdSubGrupo,
            this.p_IdMarca});
            this.Version = "17.2";
            ((System.ComponentModel.ISupportInitialize)(this.objectDataSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion

        private DevExpress.XtraReports.UI.DetailBand Detail;
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.DataAccess.ObjectBinding.ObjectDataSource objectDataSource1;
        public DevExpress.XtraReports.Parameters.Parameter p_IdEmpresa;
        public DevExpress.XtraReports.Parameters.Parameter p_IdProducto;
        public DevExpress.XtraReports.Parameters.Parameter p_IdCategoria;
        public DevExpress.XtraReports.Parameters.Parameter p_IdLinea;
        public DevExpress.XtraReports.Parameters.Parameter p_IdGrupo;
        public DevExpress.XtraReports.Parameters.Parameter p_IdSubGrupo;
        public DevExpress.XtraReports.Parameters.Parameter p_IdMarca;
    }
}
