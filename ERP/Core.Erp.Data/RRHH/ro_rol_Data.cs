using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_rol_Data
    {
        public List<ro_rol_Info> get_list_nominas(int IdEmpresa)
        {
            try
            {
                List<ro_rol_Info> Lista = new List<ro_rol_Info>();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from ROL in Context.vwro_rol
                             where ROL.IdEmpresa == IdEmpresa
                             && ROL.IdNominaTipoLiqui<=2
                             && ROL.IdNominaTipoLiqui>=1
                             select new ro_rol_Info
                             {
                                 IdEmpresa = ROL.IdEmpresa,
                                 IdNomina_Tipo = ROL.IdNominaTipo,
                                 IdNomina_TipoLiqui = ROL.IdNominaTipoLiqui,
                                 IdPeriodo = ROL.IdPeriodo,
                                 Observacion = ROL.Observacion,
                                 Descripcion = ROL.Descripcion,
                                 Cerrado = ROL.Cerrado,
                                 DescripcionProcesoNomina = ROL.DescripcionProcesoNomina,
                                 Procesado = ROL.Procesado,
                                 Contabilizado = ROL.Contabilizado,
                                 pe_FechaIni = ROL.pe_FechaIni,
                                 pe_FechaFin = ROL.pe_FechaFin

                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<ro_rol_Info> get_list_decimos(int IdEmpresa)
        {
            try
            {
                List<ro_rol_Info> Lista = new List<ro_rol_Info>();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from ROL in Context.vwro_rol
                             where ROL.IdEmpresa == IdEmpresa
                             && ROL.IdNominaTipoLiqui <= 4
                             && ROL.IdNominaTipoLiqui >= 3
                             select new ro_rol_Info
                             {
                                 IdEmpresa = ROL.IdEmpresa,
                                 IdNomina_Tipo = ROL.IdNominaTipo,
                                 IdNomina_TipoLiqui = ROL.IdNominaTipoLiqui,
                                 IdPeriodo = ROL.IdPeriodo,
                                 Observacion = ROL.Observacion,
                                 Descripcion = ROL.Descripcion,
                                 Cerrado = ROL.Cerrado,
                                 DescripcionProcesoNomina = ROL.DescripcionProcesoNomina,
                                 Procesado = ROL.Procesado,
                                 Contabilizado = ROL.Contabilizado,
                                 pe_FechaIni = ROL.pe_FechaIni,
                                 pe_FechaFin = ROL.pe_FechaFin

                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_rol_Info get_info(int IdEmpresa, int IdNominaTipo, int IdNominaTipoLiqui, int IdPeriodo)
        {
            try
            {
                 ro_rol_Info info = new  ro_rol_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                     ro_rol Entity = Context. ro_rol.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdNominaTipo == IdNominaTipo && q.IdNominaTipoLiqui==IdNominaTipoLiqui && q.IdPeriodo==IdPeriodo);
                    if (Entity == null) return null;

                    info = new  ro_rol_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdNomina_Tipo = Entity.IdNominaTipo,
                        IdNomina_TipoLiqui = Entity.IdNominaTipoLiqui,
                        IdPeriodo = Entity.IdPeriodo,
                        Observacion = Entity.Observacion,
                        Descripcion = Entity.Descripcion,
                        Cerrado = Entity.Cerrado
                    };
                }
                info.Anio =Convert.ToInt32( info.IdPeriodo.ToString().Substring(0, 4));
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool procesar( ro_rol_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Context.spRo_procesa_Rol(info.IdEmpresa, info.IdNomina_Tipo, info.IdNomina_TipoLiqui, info.IdPeriodo, info.UsuarioIngresa, info.Observacion);
                }
                return true;
            }
            catch (Exception )
            {

                throw;
            }
        }
        public bool CerrarPeriodo(ro_rol_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Context.spRo_Cierre_Rol(info.IdEmpresa, info.IdPeriodo, info.IdNomina_Tipo, info.IdNomina_TipoLiqui);
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool ContabilizarPeriodo(ro_rol_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Context.sprol_CancelarNovedades_Prestamos(info.IdEmpresa,  info.IdNomina_Tipo, info.IdNomina_TipoLiqui, info.IdPeriodo);
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool Reversar_contabilidad_Periodo(ro_rol_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Context.spRo_Reverso_Rol(info.IdEmpresa, info.IdNomina_Tipo, info.IdNomina_TipoLiqui, info.IdPeriodo);
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool AbrirPeriodo(ro_rol_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_periodo_x_ro_Nomina_TipoLiqui Entity = Context.ro_periodo_x_ro_Nomina_TipoLiqui.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa 
                    && q.IdNomina_Tipo == info.IdNomina_Tipo
                    && q.IdNomina_TipoLiqui==info.IdNomina_TipoLiqui
                    && q.IdPeriodo==info.IdPeriodo);
                    if (Entity == null)
                        return false;
                    Entity.Cerrado = "N";
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        // funciones para pago de decios

        public bool procesarDIII(ro_rol_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Context.spROL_DecimoTercero(info.IdEmpresa, info.Anio, info.region, info.UsuarioIngresa, info.Observacion);
                }
                return true;
            }
            catch (Exception )
            {

                throw;
            }
        }

        public bool procesarIV(ro_rol_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Context.spROL_DecimoCuarto(info.IdEmpresa, info.Anio, info.region, info.UsuarioIngresa, info.Observacion);
                }
                return true;
            }
            catch (Exception e)
            {

                throw;
            }
        }

    }
}
