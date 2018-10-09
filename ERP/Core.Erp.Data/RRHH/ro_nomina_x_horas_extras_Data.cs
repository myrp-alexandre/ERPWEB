using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
  public  class ro_nomina_x_horas_extras_Data
    {

        public List<ro_nomina_x_horas_extras_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<ro_nomina_x_horas_extras_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from he in Context.ro_nomina_x_horas_extras
                             join n in Context.ro_Nomina_Tipo
                             on he.IdEmpresa equals n.IdEmpresa
                             join nt in Context.ro_Nomina_Tipoliqui
                             on new { n.IdEmpresa, n.IdNomina_Tipo } equals new { nt.IdEmpresa,nt.IdNomina_Tipo }
                             join pn in Context.ro_periodo_x_ro_Nomina_TipoLiqui
                             on new { nt.IdEmpresa, nt.IdNomina_Tipo, nt.IdNomina_TipoLiqui } equals new { pn.IdEmpresa, pn.IdNomina_Tipo,pn.IdNomina_TipoLiqui }
                             join p in Context.ro_periodo
                             on new { pn.IdEmpresa, pn.IdPeriodo } equals new { p.IdEmpresa, p.IdPeriodo}
                             where he.IdEmpresa==IdEmpresa
                             && pn.IdNomina_Tipo==he.IdNominaTipo
                             && pn.IdNomina_TipoLiqui==he.IdNominaTipoLiqui
                             && pn.IdPeriodo==he.IdPeriodo
                             select new ro_nomina_x_horas_extras_Info
                             {
                                 IdEmpresa = he.IdEmpresa,
                                 IdHorasExtras = he.IdHorasExtras,
                                 IdNomina_Tipo = he.IdNominaTipo,
                                 IdNomina_TipoLiqui=he.IdNominaTipoLiqui,
                                 IdPeriodo=he.IdPeriodo,
                                 Descripcion=n.Descripcion,
                                 DescripcionProcesoNomina=nt.DescripcionProcesoNomina,
                                 pe_FechaIni=p.pe_FechaIni,
                                 pe_FechaFin=p.pe_FechaFin,
                                 Estado=he.Estado,

                                 EstadoBool = he.Estado == "A" ? true : false



                             }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_nomina_x_horas_extras_Info get_info(int IdEmpresa, int IdHorasExtras)
        {
            try
            {
                ro_nomina_x_horas_extras_Info info = new ro_nomina_x_horas_extras_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_nomina_x_horas_extras Entity = Context.ro_nomina_x_horas_extras.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdHorasExtras == IdHorasExtras);
                    if (Entity == null) return null;

                    info = new ro_nomina_x_horas_extras_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdHorasExtras = Entity.IdHorasExtras,
                        IdNomina_Tipo = Entity.IdNominaTipo,
                        IdNomina_TipoLiqui=Entity.IdNominaTipoLiqui,
                        IdPeriodo=Entity.IdPeriodo,
                        
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public int get_id(int IdEmpresa)
        {
            try
            {
                int ID = 1;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    var lst = from q in Context.ro_nomina_x_horas_extras
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdHorasExtras) + 1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool Procesar(ro_nomina_x_horas_extras_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Context.spRo_nomina_calculo_he(info.IdEmpresa, info.IdNomina_Tipo, info.IdNomina_TipoLiqui, info.IdPeriodo, info.IdUsuario, " ");
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(ro_nomina_x_horas_extras_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_nomina_x_horas_extras Entity = Context.ro_nomina_x_horas_extras.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdHorasExtras == info.IdHorasExtras);
                    if (Entity == null)
                        return false;
                    Entity.IdNominaTipo = info.IdNomina_Tipo;
                    Entity.IdNominaTipoLiqui = info.IdNomina_TipoLiqui;
                    Entity.IdPeriodo = info.IdPeriodo;
                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = info.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_nomina_x_horas_extras_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_nomina_x_horas_extras Entity = Context.ro_nomina_x_horas_extras.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdHorasExtras == info.IdHorasExtras);
                    if (Entity == null)
                        return false;
                    Entity.Estado = info.Estado = "I";
                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = info.Fecha_UltAnu = DateTime.Now;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
