using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
  public  class ro_periodo_x_ro_Nomina_TipoLiqui_Data
    {

        public List<ro_periodo_x_ro_Nomina_TipoLiqui_Info> get_list(int IdEmpresa, int IdNominaTipo, int IdNominaTipoLiq)
        {
            try
            {
                List<ro_periodo_x_ro_Nomina_TipoLiqui_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.ro_periodo_x_ro_Nomina_TipoLiqui
                             join p in Context.ro_periodo
                             on q.IdPeriodo equals p.IdPeriodo
                             where q.IdEmpresa == IdEmpresa
                             && q.IdNomina_Tipo == IdNominaTipo
                             && q.IdNomina_TipoLiqui == IdNominaTipoLiq
                             && q.IdEmpresa == p.IdEmpresa
                             select new ro_periodo_x_ro_Nomina_TipoLiqui_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdNomina_Tipo = q.IdNomina_Tipo,
                                 IdNomina_TipoLiqui = q.IdNomina_TipoLiqui,
                                 IdPeriodo=q.IdPeriodo,
                                 Contabilizado = q.Contabilizado,
                                 Cerrado = q.Cerrado,
                                 Procesado = q.Procesado,
                                 pe_FechaIni = p.pe_FechaIni,
                                 pe_FechaFin = p.pe_FechaFin
                             }).ToList();
                }
                  Lista.ForEach(v => v.descripcion = v.pe_FechaIni.ToString("dd/MM/yyyy").Substring(0, 10) + "                  al                  " + v.pe_FechaFin.ToString("dd/MM/yyyy").Substring(0, 10));
               
                return Lista;

            }
            catch (Exception)
            {

                throw;
            }
        }


        public List<ro_periodo_x_ro_Nomina_TipoLiqui_Info> get_list_utimo_periodo_aprocesar(int IdEmpresa, int IdNominaTipo, int IdNominaTipoLiq)
        {
            try
            {
                List<ro_periodo_x_ro_Nomina_TipoLiqui_Info> Lista;


                int SiguientePeriodo = 0;
              
                using (Entities_rrhh Context = new Entities_rrhh())
                {

                    SiguientePeriodo = Context.ro_periodo_x_ro_Nomina_TipoLiqui.Where(c => c.Procesado =="N").Min(c => c.IdPeriodo);
                    Lista = (from q in Context.ro_periodo_x_ro_Nomina_TipoLiqui
                             join p in Context.ro_periodo
                             on q.IdPeriodo equals p.IdPeriodo
                             where q.IdEmpresa == IdEmpresa
                             && q.IdNomina_Tipo == IdNominaTipo
                             && q.IdNomina_TipoLiqui == IdNominaTipoLiq
                             && q.IdEmpresa == p.IdEmpresa
                             && q.Procesado=="N"
                             && q.IdPeriodo== SiguientePeriodo
                             select new ro_periodo_x_ro_Nomina_TipoLiqui_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdNomina_Tipo = q.IdNomina_Tipo,
                                 IdNomina_TipoLiqui = q.IdNomina_TipoLiqui,
                                 IdPeriodo = q.IdPeriodo,
                                 Contabilizado = q.Contabilizado,
                                 Cerrado = q.Cerrado,
                                 Procesado = q.Procesado,
                                 pe_FechaIni = p.pe_FechaIni,
                                 pe_FechaFin = p.pe_FechaFin
                             }).ToList();
                }
                Lista.ForEach(v => v.descripcion = v.pe_FechaIni.ToString("dd/MM/yyyy").Substring(0, 10) + "                  al                  " + v.pe_FechaFin.ToString("dd/MM/yyyy").Substring(0, 10));

                return Lista;

            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_periodo_x_ro_Nomina_TipoLiqui_Info get_info(int IdEmpresa, int IdNomina_Tipo, int IdNominaTipoLiq, int IdPeriodo)
        {
            try
            {
                ro_periodo_x_ro_Nomina_TipoLiqui_Info info = new ro_periodo_x_ro_Nomina_TipoLiqui_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_periodo_x_ro_Nomina_TipoLiqui Entity = Context.ro_periodo_x_ro_Nomina_TipoLiqui.FirstOrDefault(q => q.IdEmpresa == IdEmpresa 
                    && q.IdNomina_Tipo == IdNomina_Tipo 
                    && q.IdNomina_TipoLiqui == IdNominaTipoLiq
                    && q.IdPeriodo==info.IdPeriodo);
                    if (Entity == null) return null;

                    info = new ro_periodo_x_ro_Nomina_TipoLiqui_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdNomina_Tipo = Entity.IdNomina_Tipo,
                        IdNomina_TipoLiqui = Entity.IdNomina_TipoLiqui,
                        Procesado = Entity.Procesado,
                        Cerrado = Entity.Cerrado,
                        Contabilizado=Entity.Contabilizado
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_periodo_x_ro_Nomina_TipoLiqui_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_periodo_x_ro_Nomina_TipoLiqui Entity = new ro_periodo_x_ro_Nomina_TipoLiqui
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdNomina_Tipo = info.IdNomina_Tipo,
                        IdNomina_TipoLiqui = info.IdNomina_TipoLiqui,
                        Procesado = "N",
                        Cerrado ="N",
                        Contabilizado = "N"
                    };
                    Context.ro_periodo_x_ro_Nomina_TipoLiqui.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }    
        public bool anularDB(ro_periodo_x_ro_Nomina_TipoLiqui_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_periodo_x_ro_Nomina_TipoLiqui Entity = Context.ro_periodo_x_ro_Nomina_TipoLiqui.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa 
                    && q.IdNomina_Tipo == info.IdNomina_Tipo 
                    && q.IdNomina_TipoLiqui == info.IdNomina_TipoLiqui 
                    && q.IdPeriodo==info.IdPeriodo);
                    if (Entity == null)
                        return false;
                    Context.ro_periodo_x_ro_Nomina_TipoLiqui.Remove(Entity);
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
