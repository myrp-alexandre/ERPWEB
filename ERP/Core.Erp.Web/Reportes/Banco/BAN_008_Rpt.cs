using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Info.Reportes.Banco;
using System.Collections.Generic;
using Core.Erp.Bus.Reportes.Banco;
using System.Linq;
using Core.Erp.Bus.General;

namespace Core.Erp.Web.Reportes.Banco
{
    public partial class BAN_008_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public int[] IntArray { get; set; }
        public BAN_008_Rpt()
        {
            InitializeComponent();
        }

        private void BAN_008_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("d/MM/yyyy hh:mm:ss");
            lbl_usuario.Text = usuario;
            lbl_empresa.Text = empresa;

            int IdEmpresa = string.IsNullOrEmpty(p_IdEmpresa.Value.ToString()) ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            DateTime fecha_ini = string.IsNullOrEmpty(p_fecha_ini.Value.ToString()) ? DateTime.Now : Convert.ToDateTime(p_fecha_ini.Value);
            DateTime fecha_fin = string.IsNullOrEmpty(p_fecha_fin.Value.ToString()) ? DateTime.Now : Convert.ToDateTime(p_fecha_fin.Value);
            int IdBanco = string.IsNullOrEmpty(p_IdBanco.Value.ToString()) ? 0 : Convert.ToInt32(p_IdBanco.Value);

            BAN_008_Bus bus_rpt = new BAN_008_Bus();
            List<BAN_008_Info> lst_rpt = new List<BAN_008_Info>();
            //List<BAN_008_Info> lst_rpt = bus_rpt.GetList(IdEmpresa, fecha_ini, fecha_fin, IdBanco);
            if (IntArray != null)
            {
                foreach (var item in IntArray)
                {
                    lst_rpt.AddRange(bus_rpt.GetList(IdEmpresa, fecha_ini, fecha_fin, item));
                }
            }
            this.DataSource = lst_rpt;

            tb_empresa_Bus bus_empresa = new tb_empresa_Bus();
            var emp = bus_empresa.get_info(IdEmpresa);
            ImageConverter obj = new ImageConverter();
            lbl_imagen.Image = (Image)obj.ConvertFrom(emp.em_logo);

            var NC = lst_rpt.Where(q => q.tc_TipoCbte == "NCB").Sum(q => q.ValorAbsoluto);
            var ND = lst_rpt.Where(q => q.tc_TipoCbte == "NDB").Sum(q => q.ValorAbsoluto);
            var DP = lst_rpt.Where(q => q.tc_TipoCbte == "DEP").Sum(q => q.ValorAbsoluto);
            var CH = lst_rpt.Where(q => q.tc_TipoCbte == "CHE").Sum(q => q.ValorAbsoluto);


            lbl_NC.Text = NC.ToString();
            lbl_ND.Text = ND.ToString();
            lbl_DP.Text = DP.ToString();
            lbl_CH.Text = CH.ToString();
        }
    }
}
