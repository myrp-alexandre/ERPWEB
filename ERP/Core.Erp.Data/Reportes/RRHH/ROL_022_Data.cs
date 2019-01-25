using Core.Erp.Data.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.RRHH
{
   public class ROL_022_Data
    {
        public List<ROL_022_Info> get_list(int IdEmpresa, int IdNomina, int IdNominaTipo, int IdPeriodo,
          int IdSucursal, int IdDivision, int IdArea, string tipoRubro)
        {
            try
            {

                ro_rubros_calculados_Data oda_rubro_calculados = new ro_rubros_calculados_Data();
                var info_rub_calculados = oda_rubro_calculados.get_info(IdEmpresa);
                info_rub_calculados.IdRubro_bono_x_antiguedad = "70";
                int IdSucursalInicio = IdSucursal;
                int IdSucursalFin = IdSucursal == 0 ? 9999 : IdSucursal;

                int IdAreaInicio = IdArea;
                int IdAreaFin = IdArea == 0 ? 9999 : IdArea;

                int IdDivisionInicio = IdDivision;
                int IdDivisionFin = IdDivision == 0 ? 9999 : IdDivision;

                List<ROL_022_Info> Lista = new List<ROL_022_Info>();
                using (Entities_reportes Context = new Entities_reportes())

                {
                    if (tipoRubro == "E")
                    {
                        //Lista = (from q in Context.VWROL_022
                        //         where q.IdEmpresa == IdEmpresa
                        //         && q.IdPeriodo == IdPeriodo
                        //       //  && q.IdDivision >= IdDivisionInicio
                        //         //&& q.IdDivision <= IdDivisionFin
                        //         && q.IdArea >= IdAreaInicio
                        //         && q.IdArea <= IdAreaFin
                        //         && IdSucursalInicio <= q.IdSucursal && q.IdSucursal <= IdSucursalFin
                        //         && q.IdArea >= IdAreaInicio
                        //         && q.IdArea <= IdAreaFin
                        //         && q.IdNominaTipo == IdNomina
                        //         && q.IdNominaTipoLiqui == IdNominaTipo
                        //         && q.Valor > 0
                        //         && (q.IdRubro == info_rub_calculados.IdRubro_bono_x_antiguedad || q.IdRubro == info_rub_calculados.IdRubro_tot_egr || q.ru_tipo == "E")
                        //         select new ROL_022_Info
                        //         {
                        //             IdEmpresa = q.IdEmpresa,
                        //             IdSucursal = q.IdSucursal,
                        //             IdNominaTipo = q.IdNominaTipo,
                        //             IdNominaTipoLiqui = q.IdNominaTipoLiqui,
                        //             IdPeriodo = q.IdPeriodo,
                        //             IdRubro = q.IdRubro,
                        //             Rubro = q.Rubro,
                        //             Area = q.Area,
                        //             ru_orden = q.ru_orden,
                        //             Valor = q.Valor,
                        //             RubroDescripcion = q.RubroDescripcion,
                        //             pe_FechaFin = q.pe_FechaFin,
                        //             pe_FechaIni = q.pe_FechaIni,
                        //             ru_tipo = q.ru_tipo,
                        //             Grupo = q.Grupo,
                        //             em_codigo = q.em_codigo,
                        //             IdEmpleado = q.IdEmpleado,
                        //             Ruc = q.Ruc,
                        //             pe_apellido = q.pe_apellido,
                        //             IdArea = q.IdArea,
                        //             NombreCompleto = q.NombreCompleto
                        //         }).ToList();
                    }
                    else if (tipoRubro == "I")
                    {
                        //Lista = (from q in Context.VWROL_022
                        //         where q.IdEmpresa == IdEmpresa
                        //         && q.IdPeriodo == IdPeriodo
                        //         && q.IdArea >= IdAreaInicio
                        //         && q.IdArea <= IdAreaFin
                        //         && IdSucursalInicio <= q.IdSucursal && q.IdSucursal <= IdSucursalFin
                        //         && q.IdArea >= IdAreaInicio
                        //         && q.IdArea <= IdAreaFin
                        //         && q.IdNominaTipo == IdNomina
                        //         && q.IdNominaTipoLiqui == IdNominaTipo
                        //         && q.Valor > 0
                        //         && (q.IdRubro == info_rub_calculados.IdRubro_tot_ing || q.ru_tipo == "I")
                        //         select new ROL_022_Info
                        //         {
                        //             IdEmpresa = q.IdEmpresa,
                        //             IdSucursal = q.IdSucursal,
                        //             IdNominaTipo = q.IdNominaTipo,
                        //             IdNominaTipoLiqui = q.IdNominaTipoLiqui,
                        //             IdPeriodo = q.IdPeriodo,
                        //             IdRubro = q.IdRubro,
                        //             Rubro = q.Rubro,
                        //             Area = q.Area,
                        //             ru_orden = q.ru_orden,
                        //             Valor = q.Valor,
                        //             RubroDescripcion = q.RubroDescripcion,
                        //             pe_FechaFin = q.pe_FechaFin,
                        //             pe_FechaIni = q.pe_FechaIni,
                        //             ru_tipo = q.ru_tipo,
                        //             Grupo = q.Grupo,
                        //             em_codigo = q.em_codigo,
                        //             IdEmpleado = q.IdEmpleado,
                        //             Ruc = q.Ruc,
                        //             pe_apellido = q.pe_apellido,
                        //             IdArea = q.IdArea,
                        //             NombreCompleto = q.NombreCompleto

                        //         }).ToList();
                    }
                    else
                    {
                        //Lista = (from q in Context.VWROL_022
                        //         where q.IdEmpresa == IdEmpresa
                        //         && q.IdPeriodo == IdPeriodo
                        //       //  && q.IdDivision >= IdDivisionInicio
                        //        // && q.IdDivision <= IdDivisionFin
                        //         && q.IdArea >= IdAreaInicio
                        //         && q.IdArea <= IdAreaFin
                        //         && IdSucursalInicio <= q.IdSucursal && q.IdSucursal <= IdSucursalFin
                        //         && q.IdArea >= IdAreaInicio
                        //         && q.IdArea <= IdAreaFin
                        //         && q.IdNominaTipo == IdNomina
                        //         && q.IdNominaTipoLiqui == IdNominaTipo
                        //         && q.Valor > 0
                        //         && (
                        //         (q.IdRubro == info_rub_calculados.IdRubro_tot_pagar
                        //         || q.IdRubro == info_rub_calculados.IdRubro_tot_ing
                        //         || q.IdRubro == info_rub_calculados.IdRubro_tot_egr
                        //         )
                        //         || (q.ru_tipo == "I" || q.ru_tipo == "E")
                        //         )
                        //         select new ROL_022_Info
                        //         {
                        //             IdEmpresa = q.IdEmpresa,
                        //             IdSucursal = q.IdSucursal,
                        //             IdNominaTipo = q.IdNominaTipo,
                        //             IdNominaTipoLiqui = q.IdNominaTipoLiqui,
                        //             IdPeriodo = q.IdPeriodo,
                        //             IdRubro = q.IdRubro,
                        //             Rubro = q.Rubro,
                        //             Area = q.Area,
                        //             ru_orden = q.ru_orden,
                        //             Valor = q.Valor,
                        //             RubroDescripcion = q.RubroDescripcion,
                        //             pe_FechaFin = q.pe_FechaFin,
                        //             pe_FechaIni = q.pe_FechaIni,
                        //             ru_tipo = q.ru_tipo,
                        //             Grupo = q.Grupo,
                        //             em_codigo = q.em_codigo,
                        //             IdEmpleado = q.IdEmpleado,
                        //             Ruc = q.Ruc,
                        //             pe_apellido = q.pe_apellido,
                        //             IdArea = q.IdArea,                                     
                        //             NombreCompleto=q.NombreCompleto

                        //         }).ToList();
                    }

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
