﻿using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Bus.Reportes.CuentasPorPagar;
using Core.Erp.Info.Reportes.CuentasPorPagar;
using System.Collections.Generic;

namespace Core.Erp.Web.Reportes.CuentasPorPagar
{
    public partial class CXP_002_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public CXP_002_Rpt()
        {
            InitializeComponent();
        }

        private void CXP_002_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {

            lbl_fecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            lbl_usuario.Text = usuario;
            int IdEmpresa_Ogiro = p_IdEmpresa_Ogiro.Value == null ? 0 : Convert.ToInt32(p_IdEmpresa_Ogiro.Value);
            int IdTipoCbte_Ogiro = p_IdTipoCbte_Ogiro.Value == null ? 0 : Convert.ToInt32(p_IdTipoCbte_Ogiro.Value);
            decimal IdCbteCble_Ogiro = p_IdCbteCble_Ogiro.Value == null ? 0 : Convert.ToDecimal(p_IdCbteCble_Ogiro.Value);

            CXP_002_Bus bus_rpt = new CXP_002_Bus();
            List<CXP_002_Info> lst_rpt = bus_rpt.get_list(IdEmpresa_Ogiro, IdTipoCbte_Ogiro, IdCbteCble_Ogiro);
            this.DataSource = lst_rpt;
        }
    }
}
