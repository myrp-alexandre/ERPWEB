using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.RRHH
{
   public class ROL_021_Data
    {
        public List<ROL_021_Info> get_list(int IdEmpresa, int IdNomina, int IdSucursal, int IdArea, int IdDivision,int IdNominaTipo, int IdPeriodo)
        {
            try
            {
               
                int IdSucursalInicio = IdSucursal;
                int IdSucursalFin = IdSucursal == 0 ? 9999 : IdSucursal;

                int IdAreaInicio = IdArea;
                int IdAreaFin = IdArea == 0 ? 9999 : IdArea;

                int IdDivisionInicio = IdDivision;
                int IdDivisionFin = IdDivision == 0 ? 9999 : IdDivision;

                List<ROL_021_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {

                        Lista = (from q in Context.VWROL_021
                                 where q.IdEmpresa == IdEmpresa
                                 && q.IdPeriodo==IdPeriodo
                                 && q.IdDivision >= IdDivisionInicio
                                 && q.IdDivision <= IdDivisionFin
                                 && q.IdArea >= IdAreaInicio
                                 && q.IdArea <= IdAreaFin

                                 && q.IdArea >= IdAreaInicio
                                 && q.IdArea <= IdAreaFin
                                 && q.IdNominaTipo == IdNomina
                                 && q.IdNominaTipoLiqui==IdNominaTipo
                                 select new ROL_021_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdRol=q.IdRol,
                                     IdSucursal=q.IdSucursal,
                                     IdNominaTipo=q.IdNominaTipo,
                                     IdNominaTipoLiqui=q.IdNominaTipoLiqui,
                                     IdPeriodo=q.IdPeriodo,
                                     IdRubro=q.IdRubro,
                                     Orden=q.Orden,
                                     Valor=q.Valor,
                                     rub_visible_reporte=q.rub_visible_reporte,
                                     Observacion=q.Observacion,
                                     ru_descripcion = q.ru_descripcion,
                                     pe_FechaFin = q.pe_FechaFin,
                                     pe_FechaIni=q.pe_FechaIni,
                                     ru_tipo=q.ru_tipo,
                                     rub_codigo=q.rub_codigo,
                                     ru_codRolGen=q.ru_codRolGen,
                                     NumHoras=q.NumHoras,
                                     ValorHora=q.ValorHora,
                                     ca_descripcion = q.ca_descripcion,
                                     em_codigo=q.em_codigo,
                                     IdEmpleado=q.IdEmpleado,
                                     pe_cedulaRuc=q.pe_cedulaRuc,
                                     pe_nombreCompleto=q.pe_nombreCompleto,
                                     Rub_horas=q.Rub_horas,
                                     IdArea=q.IdArea,
                                     IdDivision=q.IdDivision

                                 }).ToList();
                   

                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
