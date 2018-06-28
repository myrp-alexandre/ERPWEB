using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Reportes.RRHH;
namespace Core.Erp.Data.Reportes.RRHH
{
   public class ROL_002_Data
    {

        public List<ROL_002_Info> get_list(int IdEmpresa, int IdNomina, int IdNominaTipo, int IdPeriodo)
        {
            try
            {
                List<ROL_002_Info> Lista;
                string mes_nom_ = mes(IdPeriodo);

                using (Entities_reportes Context = new Entities_reportes())
                {

                    Context.SPROL_002(IdEmpresa, IdNomina, IdNominaTipo, IdPeriodo);
                    Lista = (from q in Context.VWROL_002

                             select new ROL_002_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdEmpleado = q.IdEmpleado,
                                 IdNominaTipoLiqui = q.IdNominaTipoLiqui,
                                 IdPeriodo = q.IdPeriodo,
                                 Ruc = q.Ruc,
                                 em_ruc = "RUC #"+q.em_ruc,
                                 ru_orden = q.ru_orden,
                                 NombreCompleto = q.pe_apellido + " " + q.pe_nombre,
                                 RubroDescripcion = q.RubroDescripcion,
                                 Cargo = q.Cargo,
                                 Valor = q.Valor,
                                 pe_FechaIni = q.pe_FechaIni,
                                 pe_FechaFin = q.pe_FechaFin,
                                 IdNominaTipo = q.IdNominaTipo,
                                 mes_nom = mes_nom_                           
                                 
                             }).ToList();
                }

                Lista.ForEach(v => { if (v.Valor >= 0) v.Ingresos = v.Valor; else v.Egreso = v.Valor * -1; });
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public string mes(int idperiodo)
        {
            try
            {

                string anio = idperiodo.ToString().Substring(0, 4);
                string mes_nom = "";
                if (idperiodo.ToString().Substring(4, 2) == "01")
                    mes_nom = "COMPROBANTE DE PAGO ENERO "+anio;
                if (idperiodo.ToString().Substring(4, 2) == "02")
                    mes_nom = "COMPROBANTE DE PAGO FEBRERO" + anio;
                if (idperiodo.ToString().Substring(4, 2) == "03")
                    mes_nom = "COMPROBANTE DE PAGO MARZO " + anio;
                if (idperiodo.ToString().Substring(4, 2) == "04")
                    mes_nom = "COMPROBANTE DE PAGO ABRIL " + anio;
                if (idperiodo.ToString().Substring(4, 2) == "05")
                    mes_nom = "COMPROBANTE DE PAGO MAYO " + anio;
                if (idperiodo.ToString().Substring(4, 2) == "06")
                    mes_nom = "COMPROBANTE DE PAGO JUNIO " + anio;
                if (idperiodo.ToString().Substring(4, 2) == "07")
                    mes_nom = "COMPROBANTE DE PAGO JULIO " + anio;
                if (idperiodo.ToString().Substring(4, 2) == "08")
                    mes_nom = "COMPROBANTE DE PAGO AGOSTO " + anio;
                if (idperiodo.ToString().Substring(4, 2) == "09")
                    mes_nom = "COMPROBANTE DE PAGO SEPTIEMBRE " + anio;
                if (idperiodo.ToString().Substring(4, 2) == "10")
                    mes_nom = "COMPROBANTE DE PAGO OCTUBRE " + anio;
                if (idperiodo.ToString().Substring(4, 2) == "11")
                    mes_nom = "COMPROBANTE DE PAGO NOVIEMBRE " + anio;
                if (idperiodo.ToString().Substring(4, 2) == "12")
                    mes_nom = "COMPROBANTE PAGO DICIEMBRE " + anio;

                return mes_nom;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
