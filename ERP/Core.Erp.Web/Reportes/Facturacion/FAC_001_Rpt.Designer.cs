namespace Core.Erp.Web.Reportes.Facturacion
{
    partial class FAC_001_Rpt
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
            this.p_IdSucursal = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdVendedor = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdCliente = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdCliente_contacto = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdProducto = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdProducto_padre = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_fecha_ini = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_fecha_fin = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_mostrar_anulados = new DevExpress.XtraReports.Parameters.Parameter();
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
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
            this.TopMargin.HeightF = 25F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // BottomMargin
            // 
            this.BottomMargin.HeightF = 25F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // objectDataSource1
            // 
            this.objectDataSource1.DataSource = typeof(Core.Erp.Info.Reportes.Facturacion.FAC_001_Info);
            this.objectDataSource1.Name = "objectDataSource1";
            // 
            // p_IdEmpresa
            // 
            this.p_IdEmpresa.Name = "p_IdEmpresa";
            // 
            // p_IdSucursal
            // 
            this.p_IdSucursal.Name = "p_IdSucursal";
            // 
            // p_IdVendedor
            // 
            this.p_IdVendedor.Name = "p_IdVendedor";
            // 
            // p_IdCliente
            // 
            this.p_IdCliente.Name = "p_IdCliente";
            // 
            // p_IdCliente_contacto
            // 
            this.p_IdCliente_contacto.Name = "p_IdCliente_contacto";
            // 
            // p_IdProducto
            // 
            this.p_IdProducto.Name = "p_IdProducto";
            // 
            // p_IdProducto_padre
            // 
            this.p_IdProducto_padre.Name = "p_IdProducto_padre";
            // 
            // p_fecha_ini
            // 
            this.p_fecha_ini.Name = "p_fecha_ini";
            // 
            // p_fecha_fin
            // 
            this.p_fecha_fin.Name = "p_fecha_fin";
            // 
            // p_mostrar_anulados
            // 
            this.p_mostrar_anulados.Name = "p_mostrar_anulados";
            // 
            // ReportHeader
            // 
            this.ReportHeader.HeightF = 100F;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // FAC_001_Rpt
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.ReportHeader});
            this.ComponentStorage.AddRange(new System.ComponentModel.IComponent[] {
            this.objectDataSource1});
            this.DataSource = this.objectDataSource1;
            this.Landscape = true;
            this.Margins = new System.Drawing.Printing.Margins(25, 25, 25, 25);
            this.PageHeight = 827;
            this.PageWidth = 1169;
            this.PaperKind = System.Drawing.Printing.PaperKind.A4;
            this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.p_IdEmpresa,
            this.p_IdSucursal,
            this.p_IdVendedor,
            this.p_IdCliente,
            this.p_IdCliente_contacto,
            this.p_IdProducto,
            this.p_IdProducto_padre,
            this.p_fecha_ini,
            this.p_fecha_fin,
            this.p_mostrar_anulados});
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
        public DevExpress.XtraReports.Parameters.Parameter p_IdSucursal;
        public DevExpress.XtraReports.Parameters.Parameter p_IdVendedor;
        public DevExpress.XtraReports.Parameters.Parameter p_IdCliente;
        public DevExpress.XtraReports.Parameters.Parameter p_IdCliente_contacto;
        public DevExpress.XtraReports.Parameters.Parameter p_IdProducto;
        public DevExpress.XtraReports.Parameters.Parameter p_IdProducto_padre;
        public DevExpress.XtraReports.Parameters.Parameter p_fecha_ini;
        public DevExpress.XtraReports.Parameters.Parameter p_fecha_fin;
        public DevExpress.XtraReports.Parameters.Parameter p_mostrar_anulados;
        private DevExpress.XtraReports.UI.ReportHeaderBand ReportHeader;
    }
}
