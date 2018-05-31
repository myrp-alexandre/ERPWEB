using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Reportes.RRHH;
namespace Core.Erp.Data.Reportes.RRHH
{
   public class VWROL_001_Data
    {
        public List<VWROL_001_Info> get_list(int IdEmpresa, int IdNomina, int IdNominaTipo, int IdPeriodo)
        {
            try
            {
                List<VWROL_001_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWROL_001
                             where q.IdEmpresa == IdEmpresa
                             && q.IdNominaTipo == IdNomina
                             && q.IdNominaTipoLiqui == IdNominaTipo
                             && q.IdPeriodo == IdPeriodo
                             select new VWROL_001_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdEmpleado = q.IdEmpleado,
                                 Ruc = q.pe_cedulaRuc,
                                 IdRubro = q.IdRubro,
                                 Tag = q.ru_codRolGen,
                                 Empleado = q.pe_apellido + " " + q.pe_nombre,
                                 DescRubroLargo = q.ru_descripcion,
                                 DescNombreRubroCorto = q.ru_descripcion,
                                 rub_visible_reporte = q.rub_visible_reporte,
                                 Orden = q.Orden,
                                 Valor = q.Valor,
                                 NominaLiqui = q.DescripcionProcesoNomina,
                                 Nomina = q.Nomina,
                                 FechaIni = q.pe_FechaIni,
                                 FechaFin = q.pe_FechaFin,
                                 EstadoPeriodo = q.pe_estado,
                                 Departamento = q.de_descripcion,
                                 IdNominaTipo = q.IdNominaTipo,
                                 IdNominaTipoLiqui = q.IdNominaTipoLiqui,
                                 IdPeriodo = q.IdPeriodo,
                                 Sucursal = q.Su_Descripcion,
                                 Division = q.Division,
                                 IdDivision = q.IdDivision,
                                 CodigoEmpleado = q.em_codigo,
                                 IdDepartamento = q.IdDepartamento,
                                 IdArea = q.IdArea,
                                 DescripcionArea = q.Area
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
