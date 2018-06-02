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
                                 ru_orden = q.ru_orden,
                                 NombreCompleto = q.pe_apellido + " " + q.pe_nombre,
                                 RubroDescripcion = q.RubroDescripcion,
                                 Cargo = q.Cargo,
                                 Valor = q.Valor,
                                 pe_FechaIni = q.pe_FechaIni,
                                 pe_FechaFin = q.pe_FechaFin,
                                 IdNominaTipo = q.IdNominaTipo                                
                                 
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
    }
}
